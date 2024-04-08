# SQL Interpreter Academic Project

This project is an SQL interpreter developed using Flex and Bison, tested on Fedora and Ubuntu operating systems. The interpreter parses SQL scripts and executes them accordingly.

## Installation (method 1)

To install and run the project, follow these steps:

1. Clone the repository to your local machine:

    ```
    git clone <repository_url>
    ```

2. Navigate to the project directory:

    ```
    cd sql_interpreter_project
    ```

3. Compile the Flex file (`sql.l`):

    ```
    flex sql.l
    ```

4. Compile the Bison file (`sql.y`):

    ```
    bison -d sql.y
    ```

5. Compile the generated Bison output file and other necessary files:

    ```
    gcc sql.tab.c -o sql
    ```
## Installation (method 2)
1. using script :
2. chmod +x compie_me.sh
3. ./compile_me.sh
4. if you want to clean binaries :
5. chmod +x clean.sh
6. ./clean.sh

## Usage

Once the project is compiled, you can run it with an SQL script file as input. The input file should contain the SQL queries you want to execute. For example:

./sql < test.txt


Replace `test.txt` with the name of your input file.

## Compatibility

The project has been tested on Fedora and Ubuntu operating systems. It should work on other Unix-like systems with Flex and Bison installed.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or create a pull request on the repository.

## License

This project is licensed under the [MIT License](LICENSE).
