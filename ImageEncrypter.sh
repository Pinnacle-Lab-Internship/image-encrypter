#!/bin/bash

encrypt_image() {
    local input_file="$1"
    local output_file="$2"
    local recipient_email="$3"

    # Encrypt the image file
    gpg --output "$output_file" --recipient "$recipient_email" --encrypt "$input_file"
    
    echo "Image file encrypted successfully."
    echo "Encrypted file: $output_file"
}

decrypt_image() {
    local input_file="$1"
    local output_file="$2"
    local recipient_email="$3"

    # Decrypt the image file
    gpg --output "$output_file" --recipient "$recipient_email" --decrypt "$input_file"
    
    echo "Encrypted file decrypted successfully."
    echo "Decrypted file: $output_file"
}

print_usage() {
    echo "Usage: $0 -i <input_file> -o <output_file> -e <recipient_email> [-d]"
}

main() {
    INPUT_FILE=""
    OUTPUT_FILE=""
    RECIPIENT_EMAIL=""
    DECRYPT_FLAG=0

    # Parse options
    while getopts ":i:o:e:d" opt; do
        case $opt in
            i) INPUT_FILE="$OPTARG";;
            o) OUTPUT_FILE="$OPTARG";;
            e) RECIPIENT_EMAIL="$OPTARG";;
            d) DECRYPT_FLAG=1;;
            \?) echo "Invalid option: -$OPTARG" >&2
                print_usage
                exit 1;;
            :) echo "Option -$OPTARG requires an argument." >&2
                print_usage
                exit 1;;
        esac
    done

    # Check if required options are provided
    if [ -z "$INPUT_FILE" ] || [ -z "$OUTPUT_FILE" ] || [ -z "$RECIPIENT_EMAIL" ]; then
        echo "Error: Missing required options."
        print_usage
        exit 1
    fi

    # Encrypt or decrypt the image file based on the flag
    if [ $DECRYPT_FLAG -eq 0 ]; then
        # Encrypt the image file
        if [ -f "$INPUT_FILE" ]; then
            encrypt_image "$INPUT_FILE" "$OUTPUT_FILE" "$RECIPIENT_EMAIL"
        else
            echo "Error: Input file not found."
            exit 1
        fi
    else
        # Decrypt the image file
        if [ -f "$INPUT_FILE" ]; then
            decrypt_image "$INPUT_FILE" "$OUTPUT_FILE" "$RECIPIENT_EMAIL"
        else
            echo "Error: Encrypted file not found."
            exit 1
        fi
    fi
}

main "$@"
