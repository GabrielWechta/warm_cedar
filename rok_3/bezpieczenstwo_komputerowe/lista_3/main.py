from typing import List
import binascii
import sys

const_space = ord(' ')


def main():
    try:
        with open(sys.argv[1]) as file:
            cipher_texts = [binascii.unhexlify(line.rstrip()) for line in file]
    except Exception as e:
        print('some error {}'.format(e))
        raise SystemExit(-1)

    clear_texts = [bytearray(b'?' * len(line)) for line in cipher_texts]  # generating lists with given bytes length

    solve(cipher_texts, clear_texts)


def solve(ciphertexts: List[bytes], cleartexts: List[bytearray]) -> None:
    longest_length = max(len(line) for line in ciphertexts)
    key = bytearray(longest_length)
    key_mask = [False] * longest_length
    for column in range(longest_length):
        left_ciphers = [line for line in ciphertexts if len(line) > column]
        for cipher in left_ciphers:
            if is_space_check(left_ciphers, cipher[column], column):
                """
                if we get cipher[column] xor with every byte int left_ciphers in given column
                >= 65 or == 0 we have found a space!
                """
                key[column] = cipher[column] ^ const_space
                key_mask[column] = True
                i = 0
                for clear_row in range(len(cleartexts)):
                    if len(cleartexts[clear_row]) != 0 and column < len(cleartexts[clear_row]):  # checking if inside
                        result = cipher[column] ^ left_ciphers[i][column]
                        if result == 0:
                            cleartexts[clear_row][column] = const_space
                            """
                            when you xor two times you get value shifted by 32.
                            """
                        elif chr(result).isupper():
                            cleartexts[clear_row][column] = ord(chr(result).lower())
                        elif chr(result).islower():
                            cleartexts[clear_row][column] = ord(chr(result).upper())
                        i += 1
                break
    for line in cleartexts:
        try:
            print(line.decode('ascii'), end="\n")
        except Exception:
            for letter in line:
                print(chr(letter), sep="", end="")


def is_space_check(rows, current, column) -> bool:
    for row in rows:
        # print(row[column], current)
        result = row[column] ^ current
        if not (chr(result).isalpha() or result == 0):
            return False
    return True


if __name__ == '__main__':
    main()
    print()
