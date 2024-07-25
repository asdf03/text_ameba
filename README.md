# Text Ameba

Text Ameba is a simple script designed to process text input, trimming leading and trailing whitespace from each line and formatting the cleaned lines into a specific output format. 

## How to Use

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/text-ameba.git
    cd text-ameba
    ```

2. Run the script:
    ```bash
    ./ameba
    ```

3. Follow the prompt to enter text. To end the input, press `Enter` and then `Ctrl+D`.

4. The script will output the processed text.

## Script Details

The script consists of two main functions:

### `process_input`

This function reads the user input line by line, trims leading and trailing whitespace, and formats each line into the desired output. The cleaned and formatted lines are then combined into a single string, separated by commas and newlines.

### `ameba`

This function serves as the entry point to the script. It displays a welcome message, prompts the user to input text, and then calls the `process_input` function to handle the text processing.

## Example

When you run the script and input the following text:

```
Hello World
This is a test.
```

The output will be:

```
( ´･ω･)⊃ ｽｯ
'Hello World',
'This is a test.'
````

## Adding to .bashrc

To make the `ameba` command available globally, you can add the following line to your `.bashrc` file:

```bash
alias ameba='/path/to/your/ameba/script/ameba'
```

Replace `/path/to/your/ameba/script/ameba` with the actual path to your `ameba` script. After adding this line, run the following command to reload your `.bashrc`:

```bash
source ~/.bashrc
```

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
