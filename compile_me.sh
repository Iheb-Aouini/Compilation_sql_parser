bison -d sql.y ;
flex sql.l;
gcc sql.tab.c -o  sql ;

#executing the project :   ./projet < test.txt   



