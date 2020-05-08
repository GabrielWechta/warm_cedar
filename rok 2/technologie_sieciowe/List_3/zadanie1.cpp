#include <iostream>
#include <fstream>

#define PACKAGE_SIZE 16

using namespace std;

string begEndWrap(string line) {
    return "01111110" + line + "01111110";
//    return "01111110 " + line + " 01111110";
}

string fiveOnesFix(string line) {
    int ones_counter = 0;
    for (int i = 0; i < line.length(); i++) {
        if (line[i] == '1') {
            ones_counter++;
            if (ones_counter == 5) {
                line.insert(i + 1, "0");
                i++;
                ones_counter = 0;
            }
        } else {
            ones_counter = 0;
        }
    }
    return line;
}

string getCRC(string line) {
    string divisor = "1011";
    line = line + "000";
    for (int i = 0; i <= line.length() - 4; i++) {
//        cout << line << "\n";
        if (line[i] == '1') {
            for (int j = 0; j < 4; j++) {
                if (line[i + j] == divisor[j]) {
                    line[i + j] = '0';
                } else {
                    line[i + j] = '1';
                }
            }
        }
    }
//    return " " + line.substr(line.length() - 3, line.length() - 1);
    return line.substr(line.length() - 3, line.length() - 1);
}

/** line is already appended by crc code */
bool checkCRC(string line) {
    string divisor = "1011";
    for (int i = 0; i <= line.length() - 4; i++) {
        if (line[i] == '1') {
            for (int j = 0; j < 4; j++) {
                if (line[i + j] == divisor[j]) {
                    line[i + j] = '0';
                } else {
                    line[i + j] = '1';
                }
            }
        }
    }
    for (char i : line) {
        if (i == '1') return false;
    }

    return true;
}

string decode(string line) {
    if (line.substr(0, 8) != "01111110") return "broken";
    else line = line.substr(8, line.length());

    if (line.substr(line.length() - 8, line.length()) != "01111110") return "broken";
    else line = line.substr(0, line.length() - 8);

    if (checkCRC(line)) {
        line = line.substr(0, line.length() - 3);
    } else return "broken";

    int ones_counter = 0;
    for (int i = 0; i < line.length(); i++) {
        if (line[i] == '1') {
            ones_counter++;
            if (ones_counter == 5) {
                line.erase(i + 1, 1);
                ones_counter = 0;
            }
        } else {
            ones_counter = 0;
        }
    }
    return line;
}

int main() {
    fstream input_file, output_file;
    input_file.open("/home/gabriel/CLionProjects/Ts3/Z.txt", fstream::in);
    output_file.open("/home/gabriel/CLionProjects/Ts3/W.txt", fstream::out);

    string line, package;
    if (input_file.is_open()) {
        getline(input_file, line);
        for (int i = 0; i <= line.length() / PACKAGE_SIZE; i++) {
            package = line.substr(i * PACKAGE_SIZE, PACKAGE_SIZE);
            if (package.empty()) break;
            package = fiveOnesFix(package);
            package = package + getCRC(package);
            package = begEndWrap(package);
            output_file << package << "\n";
        }
    }
    output_file.close();
    output_file.open("/home/gabriel/CLionProjects/Ts3/W.txt", fstream::in);

    string coded_line, master_line;
    int line_number = 0;
    if (output_file.is_open()) {
        while (getline(output_file, coded_line)) {
            line_number++;
            coded_line = decode(coded_line);
            if (coded_line == "broken")
                master_line += "!( resend: " + to_string(line_number) + " package, please. )!";
            else master_line += coded_line;
        }
        cout << "After encoding and decoding: " + master_line + "\n";
        cout << "Original input:              " + line + "\n";
    }


}
