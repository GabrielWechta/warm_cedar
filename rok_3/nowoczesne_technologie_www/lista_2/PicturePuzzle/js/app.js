let PUZZLE_DIFFICULTY_ROWS = 4;
let PUZZLE_DIFFICULTY_COL = 4;
const PUZZLE_HOVER_TINT = '#009900';

var _canvas;
var _stage;

var _img;
var _pieces;
var _puzzleWidth;
var _puzzleHeight;
var _pieceWidth;
var _pieceHeight;
var _currentPiece;
var _currentDropPiece;

var _mouse;

function init() {
    _img = new Image();
    _img.addEventListener('load', onImage, false);
    _img.src = "resources/full/zelda.jpg";
}

function getImage(url) {
    return new Promise(
        function (resolve, reject) {
            _img.onload = function () {
                resolve(url);
            };
            _img.onerror = function () {
                reject(url);
            };
            _img.src = url;
        }
    );
}

function onSuccess(url) {
    _img.src = url;
}

function onFailure(url) {
    console.log("Error loading " + url);
}

function loadFull(img) {
    var promise = getImage(img.src.replace("compressed", "full"))
    promise.then(onSuccess).catch(onFailure)
}

function reset() {
    var sliderRows = document.getElementById("sliderRows");
    var outputRows = document.getElementById("amtOutputRows");

    outputRows.innerHTML = sliderRows.value;
    sliderRows.oninput = function () {
        outputRows.innerHTML = this.value;
    }
    PUZZLE_DIFFICULTY_ROWS = sliderRows.value;

    var sliderColumns = document.getElementById("sliderColumns");
    var outputColumns = document.getElementById("amtOutputColumns");

    outputColumns.innerHTML = sliderColumns.value;
    sliderColumns.oninput = function () {
        outputColumns.innerHTML = this.value;

    }
    PUZZLE_DIFFICULTY_COL = sliderColumns.value;

    onImage()
}

function onImage(e) {
    _pieceWidth = Math.floor(_img.width / PUZZLE_DIFFICULTY_COL)
    _pieceHeight = Math.floor(_img.height / PUZZLE_DIFFICULTY_ROWS)
    _puzzleWidth = _pieceWidth * PUZZLE_DIFFICULTY_COL;
    _puzzleHeight = _pieceHeight * PUZZLE_DIFFICULTY_ROWS;
    setCanvas();
    initPuzzle();
}

function setCanvas() {
    _canvas = document.getElementById('canvas');
    _stage = _canvas.getContext('2d');
    _canvas.width = _puzzleWidth;
    _canvas.height = _puzzleHeight;
    _canvas.style.border = "1px solid black";
}

function initPuzzle() {
    _pieces = [];
    _mouse = {x: 0, y: 0};
    _currentPiece = null;
    _currentDropPiece = null;
    _stage.drawImage(_img, 0, 0, _puzzleWidth, _puzzleHeight, 0, 0, _puzzleWidth, _puzzleHeight);
    createTitle("Click to shuffle");
    buildPieces();
}

function createTitle(msg) {
    _stage.fillStyle = "#000000";
    _stage.globalAlpha = .2;
    _stage.fillRect(100, _puzzleHeight - 40, _puzzleWidth - 200, 40);
    _stage.fillStyle = "#aaaaaa";
    _stage.globalAlpha = 1;
    _stage.textAlign = "center";
    _stage.textBaseline = "middle";
    _stage.font = "20px Arial";
    _stage.fillText(msg, _puzzleWidth / 2, _puzzleHeight - 20);
}


function buildPieces() {
    var i;
    var piece;
    var xPos = 0;
    var yPos = 0;
    for (i = 0; i < PUZZLE_DIFFICULTY_COL * PUZZLE_DIFFICULTY_ROWS; i++) {
        piece = {};
        piece.sx = xPos;
        piece.sy = yPos;
        piece.empty = false;
        _pieces.push(piece);
        xPos += _pieceWidth;
        if (xPos >= _puzzleWidth) {
            xPos = 0;
            yPos += _pieceHeight;
        }
    }

    _canvas.onmousedown = shufflePuzzle;
}

function shuffleArray(o) {
    for (var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x) ;
    return o;
}

function makeMatrix(array) {
    var matrix = []
    for (let i = 0; i < PUZZLE_DIFFICULTY_ROWS; i++) {
        var line = []
        for (let j = 0; j < PUZZLE_DIFFICULTY_COL; j++) {
            line.push(array[PUZZLE_DIFFICULTY_COL * i + j])
        }
        matrix.push(line)
    }
    return matrix
}

function countInversions(i, j, matrix) {
    var inversions = 0;
    var tileNum = j * PUZZLE_DIFFICULTY_COL + i;
    var lastTile = PUZZLE_DIFFICULTY_COL * PUZZLE_DIFFICULTY_ROWS;
    var tileValue = matrix[i][j].sy / _pieceHeight * PUZZLE_DIFFICULTY_COL + matrix[i][j].sx / _pieceWidth;
    for (var q = tileNum + 1; q < lastTile; ++q) {
        var k = q % PUZZLE_DIFFICULTY_COL;
        var l = Math.floor(q / PUZZLE_DIFFICULTY_ROWS);
        try {
            var compValue = matrix[k][l].sy / _pieceHeight * PUZZLE_DIFFICULTY_COL + matrix[k][l].sx / _pieceWidth;
            if (tileValue > compValue && tileValue !== (lastTile - 1)) {
                ++inversions;
            }
        } catch (e) {
            console.log(e)
        }

    }
    return inversions;
}

function sumInversions(matrix) {
    var inversions = 0;
    for (var j = 0; j < PUZZLE_DIFFICULTY_COL; ++j) {
        for (var i = 0; i < PUZZLE_DIFFICULTY_ROWS; ++i) {
            inversions += countInversions(i, j, matrix);
        }
    }
    return inversions;
}

function shufflePuzzle() {
    _canvas.onmousedown = null
    let inversions = -1;
    while (inversions % 2 !== 0) {
        _pieces = shuffleArray(_pieces);
        inversions = sumInversions(makeMatrix(_pieces));
    }
    console.log(inversions)
    _stage.clearRect(0, 0, _puzzleWidth, _puzzleHeight);
    var i;
    var piece;
    var xPos = 0;
    var yPos = 0;
    for (i = 0; i < _pieces.length; i++) {
        piece = _pieces[i];
        piece.xPos = xPos;
        piece.yPos = yPos;
        if (xPos === 0 && yPos === 0) {
            piece.empty = true;
        }
        if (piece.empty === false) {
            _stage.drawImage(_img, piece.sx, piece.sy, _pieceWidth, _pieceHeight, xPos, yPos, _pieceWidth, _pieceHeight);
            _stage.strokeRect(xPos, yPos, _pieceWidth, _pieceHeight);
        } else {
            _stage.strokeRect(xPos, yPos, _pieceWidth, _pieceHeight);
        }
        xPos += _pieceWidth;
        if (xPos >= _puzzleWidth) {
            xPos = 0;
            yPos += _pieceHeight;
        }
    }

    for (i = 0; i < _pieces.length; i++) {
        piece = _pieces[i];
    }

    document.onmousedown = onPuzzleClick;
    document.onmousemove = onPuzzleHover;
}

function findPieceByPos(slidePiece) {
    console.log(slidePiece)
    let piece;
    for (let i = 0; i < _pieces.length; i++) {
        piece = _pieces[i];
        console.log(piece)
        if (piece.xPos === slidePiece.xPos && piece.yPos === slidePiece.yPos) {

            return piece;
        }
    }
}

function tem() {
    var slidePiece = {}
    var emptyPiece = {}
    emptyPiece.xPos = 0;
    emptyPiece.yPos = 0;
    slidePiece.xPos = 0;
    slidePiece.yPos = 0;

    var direction = 0;
    for (var i = 0; i < 30; i++) {
        direction = Math.floor(Math.random() * 4);
        console.log(direction)
        slidePiece.xPos = emptyPiece.xPos;
        slidePiece.yPos = emptyPiece.yPos;
        if (direction === 0 && slidePiece.xPos > 0) {
            slidePiece.xPos = slidePiece.xPos - _pieceWidth;
            console.log("1")
        } else if (direction === 1 && slidePiece.yPos > 0) {
            slidePiece.yPos = slidePiece.yPos - _pieceHeight;
            console.log("2")
        } else if (direction === 2 && slidePiece.xPos < (_puzzleWidth)) {
            slidePiece.xPos = slidePiece.xPos + _pieceWidth;
            console.log("3")
        } else if (direction === 3 && slidePiece.yPos < (_puzzleHeight)) {
            slidePiece.yPos = slidePiece.yPos + _pieceHeight;
            console.log("4")
        }
        // console.log(slidePiece)
        var tmp = findPieceByPos(slidePiece);
        console.log(tmp)
        swapPieces(emptyPiece, tmp);

        for (let j = 0; j < _pieces.length; j++) {
            piece = _pieces[j];
            if (piece.empty !== true) {
                _stage.drawImage(_img, piece.sx, piece.sy, _pieceWidth, _pieceHeight, piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
                _stage.strokeRect(piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
            } else {
                _stage.strokeRect(piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
            }
        }
    }
}


function getEmptyNeighbour(cp) {
    let piece;
    for (let i = 0; i < _pieces.length; i++) {
        piece = _pieces[i];
        if (piece.empty === true) {
            if ((cp.xPos - _pieceWidth === piece.xPos && cp.yPos === piece.yPos) ||
                (cp.xPos + _pieceWidth === piece.xPos && cp.yPos === piece.yPos) ||
                (cp.yPos - _pieceHeight === piece.yPos && cp.xPos === piece.xPos) ||
                (cp.yPos + _pieceHeight === piece.yPos && cp.xPos === piece.xPos)) {
                return piece;
            }
        }
    }
    return null;
}

function onPuzzleHover(e) {
    if (e.layerX || e.layerX == 0) {
        _mouse.x = e.layerX - _canvas.offsetLeft;
        _mouse.y = e.layerY - _canvas.offsetTop;
    } else if (e.offsetX || e.offsetX == 0) {
        _mouse.x = e.offsetX - _canvas.offsetLeft;
        _mouse.y = e.offsetY - _canvas.offsetTop;
    }

    _currentPiece = checkPieceClicked();
    if (_currentPiece != null) {
        const empty_piece = getEmptyNeighbour(_currentPiece);
        if (empty_piece != null) {
            _stage.save();
            _stage.globalAlpha = .05;
            _stage.fillStyle = PUZZLE_HOVER_TINT;
            _stage.fillRect(_currentPiece.xPos, _currentPiece.yPos, _pieceWidth, _pieceHeight);
            _stage.restore();
        } else {
            for (i = 0; i < _pieces.length; i++) {
                piece = _pieces[i];
                if (piece.empty !== true) {
                    _stage.drawImage(_img, piece.sx, piece.sy, _pieceWidth, _pieceHeight, piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
                    _stage.strokeRect(piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
                }
            }
        }

    }
}

function swapPieces(first, second) {
    let tmp;
    tmp = first.xPos;
    first.xPos = second.xPos;
    second.xPos = tmp;

    tmp = first.yPos;
    first.yPos = second.yPos;
    second.yPos = tmp;
}

function onPuzzleClick(e) {
    if (e.layerX || e.layerX == 0) {
        _mouse.x = e.layerX - _canvas.offsetLeft;
        _mouse.y = e.layerY - _canvas.offsetTop;
    } else if (e.offsetX || e.offsetX == 0) {
        _mouse.x = e.offsetX - _canvas.offsetLeft;
        _mouse.y = e.offsetY - _canvas.offsetTop;
    }

    _currentPiece = checkPieceClicked();

    if (_currentPiece != null) {
        const empty_piece = getEmptyNeighbour(_currentPiece);

        if (empty_piece != null) {
            _stage.clearRect(_currentPiece.xPos, _currentPiece.yPos, _pieceWidth, _pieceHeight);

            swapPieces(_currentPiece, empty_piece);
            // _stage.save();
            resetPuzzleAndCheckWin()
            // _stage.restore();
        }
    }

}

function checkPieceClicked() {
    var i;
    var piece;
    for (i = 0; i < _pieces.length; i++) {
        piece = _pieces[i];
        if (_mouse.x < piece.xPos || _mouse.x > (piece.xPos + _pieceWidth) || _mouse.y < piece.yPos || _mouse.y > (piece.yPos + _pieceHeight)) {
            //PIECE NOT HIT
        } else {
            return piece;
        }
    }
    return null;
}

function resetPuzzleAndCheckWin() {
    _stage.clearRect(0, 0, _puzzleWidth, _puzzleHeight);
    var gameWin = true;
    var i;
    var piece;
    for (i = 0; i < _pieces.length; i++) {
        piece = _pieces[i];
        if (piece.empty !== true) {
            _stage.drawImage(_img, piece.sx, piece.sy, _pieceWidth, _pieceHeight, piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
            _stage.strokeRect(piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
        } else {
            _stage.strokeRect(piece.xPos, piece.yPos, _pieceWidth, _pieceHeight);
        }
        if (piece.xPos != piece.sx || piece.yPos != piece.sy) {
            gameWin = false;
        }
    }
    if (gameWin) {
        setTimeout(gameOver, 500);
    }
}

function gameOver() {
    document.onmousedown = null;
    document.onmousemove = null;
    document.onmouseup = null;
    initPuzzle();
}
