import ply

from ply import lex
from ply import yacc

""" ---------------------------- LEXER PART ---------------------------- """

tokens = (
    'NEWLINE', 'NUMBER', 'PLUS', 'MINUS', 'TIMES', 'DIVIDE', 'LPAREN', 'RPAREN', 'EXPONENT', 'COMMENT', 'IGNORE',
    'LINECONT'
)


def t_COMMENT(t):
    r'\#.*'
    pass


def t_IGNORE(t):
    r' \t'
    pass


def t_LINECONT(t):
    r'\\\n'
    pass


def t_NUMBER(t):
    r'\d+'
    t.value = int(t.value)
    return t


def t_NEWLINE(t):
    r'\n'
    t.value = '\n'
    return t


def t_PLUS(t):
    r'\+'
    t.value = '+'
    return t


def t_MINUS(t):
    r'-'
    t.value = '-'
    return t


def t_TIMES(t):
    r'\*'
    t.value = '*'
    return t


def t_DIVIDE(t):
    r'/'
    t.value = '/'
    return t


def t_EXPONENT(t):
    r'\^'
    t.value = '^'
    return t


def t_LPAREN(t):
    r'\('
    t.value = '('
    return t


def t_RPAREN(t):
    r'\)'
    t.value = ')'
    return t


def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


t_ignore = ' \t'


def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)


lexer = lex.lex()

data = '3 + 4 * 10 ^ -20 *2'

# Give the lexer some input
lexer.input(data)

# Tokenize
# while True:
#     tok = lexer.token()
#     if not tok:
#         break  # No more input
#     print(tok)

""" ---------------------------- PARSER PART ---------------------------- """


def extended_gcd(aa, bb):
    lastremainder, remainder = abs(aa), abs(bb)
    x, lastx, y, lasty = 0, 1, 1, 0
    while remainder:
        lastremainder, (quotient, remainder) = remainder, divmod(lastremainder, remainder)
        x, lastx = lastx - quotient * x, x
        y, lasty = lasty - quotient * y, y
    return lastremainder, lastx * (-1 if aa < 0 else 1), lasty * (-1 if bb < 0 else 1)


def modinv(a, m):
    g, x, y = extended_gcd(a, m)
    if g != 1:
        raise ValueError
    return x % m


def modexp(x, exp, N):
    if x == 0:
        return 0
    if exp == 0:
        return 1

    if exp % 2 == 0:
        y = modexp(x, exp // 2, N)
        y = (y * y) % N
    else:
        y = x % N
        y = (y * modexp(x, exp - 1, N) % N) % N

    return (y + N) % N


rpn = ""
p = 1234577

precedence = (
    ('left', 'PLUS', 'MINUS'),
    ('left', 'TIMES', 'DIVIDE'),
    ('right', 'UMINUS'),
    ('right', 'EXPONENT')
)


def p_statement_expr(t):
    'statement : expression'
    global rpn
    print(rpn)
    print("Wynik: ", t[1])
    rpn = ""


def p_expexponent_number(t):
    '''expexponent : NUMBER
            | MINUS NUMBER %prec UMINUS'''
    global rpn
    if t[1] != '-':
        t[0] = t[1] % (p - 1)
        rpn += str(t[0]) + " "
    else:
        t[0] = -t[2] % (p - 1)
        rpn += str(t[0]) + " "


def p_num_uminus(t):
    '''num : NUMBER
            | MINUS NUMBER %prec UMINUS'''
    global rpn
    if t[1] != '-':
        t[0] = t[1] % p
        rpn += str(t[0]) + " "
    else:
        t[0] = -t[2] % p
        rpn += str(t[0]) + " "


def p_expression_binop(t):
    '''expression : expression PLUS expression
                  | expression MINUS expression
                  | expression TIMES expression
                  | expression DIVIDE expression
                  | expression EXPONENT expexponent
                  | LPAREN expression RPAREN'''
    global rpn
    if t[2] == '+':
        rpn += "+ "
        t[0] = (t[1] + t[3]) % p
    elif t[2] == '-':
        rpn += "- "
        t[0] = (t[1] - t[3]) % p
    elif t[2] == '*':
        rpn += "* "
        t[0] = (t[1] * t[3]) % p
    elif t[2] == '/':
        rpn += "/ "
        inverse = modinv(t[3], p)
        t[0] = (t[1] * inverse) % p
    elif t[2] == '^':
        rpn += "^ "
        t[0] = modexp(t[1], t[3], p)
    elif t[1] == '(' and t[3] == ')':
        t[0] = t[2]



def p_expression_number(t):
    'expression : num'
    t[0] = t[1]


def p_error(t):
    try:
        print("Syntax error at '%s'" % t.value)
    except:
        pass

parser = yacc.yacc()

while True:
    try:
        s = input('calc > ')  # Use raw_input on Python 2
    except EOFError:
        break
    parser.parse(s)

if __name__ == '__main__':
    pass
