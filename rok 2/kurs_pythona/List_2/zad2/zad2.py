import base64
import sys

BASE64_LIST = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
               'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
               'q',
               'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/']


def my_base64_encode(byte_string):
    i = 0
    encoded = ""
    two_is_up = False
    four_is_up = False
    while i < len(byte_string):
        string_of_six_bits = byte_string[i: i + 6]
        if len(string_of_six_bits) != 6:
            if len(string_of_six_bits) == 2:
                string_of_six_bits += '0000'
                two_is_up = True
            if len(string_of_six_bits) == 4:
                string_of_six_bits += '00'
                four_is_up = True
        # print(string_of_six_bits)
        value = int(string_of_six_bits, 2)
        # print(value)
        encoded += BASE64_LIST[value]
        i += 6
    if two_is_up: encoded += "=="
    if four_is_up: encoded += "="
    return encoded


def my_base64_decode(ascii_string):
    decoded = []
    string_of_bites = ""
    for character in ascii_string:
        if character == "=":
            string_of_bites += "0000"
        else:
            i = BASE64_LIST.index(character)
            string_of_bites += '{0:06b}'.format(i)

    i = 0
    while i < len(string_of_bites):
        string_of_eight_bites = string_of_bites[i: i + 8]
        value = int(string_of_eight_bites, 2)
        decoded.append(value)
        i += 8
    decoded = bytearray(decoded)
    return decoded


arguments = sys.argv
if arguments[1] == "--encode":
    with open(arguments[2], 'rb') as binary_file_to_code:
        content = binary_file_to_code.read()
    with open(arguments[3], 'w') as file_to_write:
        byte_string = ""
        for byte in content:
            byte_string += '{0:08b}'.format(byte)
        my_encoded = my_base64_encode(byte_string)
        file_to_write.write(my_encoded)

elif arguments[1] == "--decode":
    with open(arguments[2], 'r') as file_to_read:
        content = file_to_read.read()
        my_decoded = my_base64_decode(content)

    with open(arguments[3], 'wb') as binary_file_to_write:
        binary_file_to_write.write(my_decoded)
else:
    print("Would you kindly use '--encode' or '--decode' options?")
