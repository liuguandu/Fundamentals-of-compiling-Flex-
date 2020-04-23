/*
 *file: C-lexical-analyzer.l 
 *auther: jin1ming
 *system: manjaro
 */
%option yylineno
%{
#include<stdio.h>
#include<string.h>
int Oct2Dec(char temp[]);
float d_Oct2Dec(char temp[]);
int Hex2Dec(char temp[]);
float d_Hex2Dec(char temp[]);
int IsDecimals(char temp[]);
extern int yylineno;
%}

/*数字定义*/
/*科学计数表示*/
science {decimal}(\.[0-9]+)?([Ee][-+]?[0-9]+)?
/*十进制*/
decimal (0|[1-9][0-9]*)(\.[0-9][0-9]*)?
/*十六进制*/
hexadecimal 0[xX][a-fA-F0-9]+(\.[0-9a-fA-F][0-9a-fA-F]+)?
/*二进制*/
binary 0[bB][01]+
/*八进制*/
octal 0[0-7]+(\.[0-7][0-7]+)?
/*总表示*/
number ({hexadecimal}|{binary}|{science}|{octal})(([uU]?[Ll]?)|([Ll]?[Uu]?)|([fF]?))
/*注意浮点数总是有符号，不需要Uu后缀，所以在接下来单做一个浮点数异常处理*/
/*数字异常处理*/
floatexcption {decimal}\.[0-9]+([Ee]?[-+]?[0-9]+)?[Uu]
excption [0-9][0-9a-zA-Z\.]+

/*关键字*/
BREAK break
CASE case
CHAR char
CONTINUE continue
DEFAULT default
DO do
DOUBLE double
ELSE else
FLOAT float
FOR for
IF if
INT int
LONG long 
RETURN return
SHORT short
SIGNED signed
SWITCH switch
UNSIGNED unsigned
VOID void 
WHILE while

/*标识符定义*/
identifier [a-zA-Z][a-zA-Z0-9]*([_\.][a-zA-Z0-9]+)?

/*其它字符*/
comment (\/\/.*)|(\/\*(.|\n)*\/)
whitespace [ \t\n\r\f\v]+
errno .
 
 /*运算符*/
 /*算术运算符*/
ADD  \+
SUB  \-
MUL  \*
QUO  \/
REM  %
INC    \+\+
DEC    \-\-
 /*赋值运算符*/
ASSIGN  =
ADD_ASSIGN  \+=
SUB_ASSIGN  \-=
MUL_ASSIGN  \*=
QUO_ASSIGN  \/=
REM_ASSIGN  %=
AND_ASSIGN  \&=
OR_ASSIGN  \|=
XOR_ASSIGN  \^=
SHL_ASSIGN  <<=
SHR_ASSIGN  >>=
AND_NOT_ASSIGN  ~=
 /*位运算符*/
AND      &
OR       \|
XOR      \^
SHL      <<
SHR      >>
AND_NOT  ~
 /*逻辑运算符*/
LAND   &&
LOR    \|\|
NOT    \!
 /*关系运算符*/
EQL     ==
LSS     <
GTR     >
NEQ       !=
LEQ       <=
GEQ       >=
 /*标点符号*/
LPAREN  \(
LBRACK  \[
LBRACE  \{
COMMA   ,
PERIOD  \.
RPAREN     \)
RBRACK     \]
RBRACE     \}
SEMICOLON  ;
COLON      :
POT         \->
DQUA       \"
SQUA       \'
%%
 
 /*关键字*/
{BREAK} {printf("BREAK\t_\n");}
{CASE} {printf("CASE\t_\n");}
{CHAR} {printf("CHAR\t_\n");}
{CONTINUE} {printf("CONTINUE\t_\n");}
{DEFAULT} {printf("DEFAULT\t_\n");}
{DO} {printf("DO\t_\n");}
{DOUBLE} {printf("DOUBLE\t_\n");}
{ELSE} {printf("ELSE\t_\n");}
{FLOAT} {printf("FLOAT\t_\n");}
{FOR} {printf("FOR\t_\n");}
{IF} {printf("IF\t_\n");}
{INT} {printf("INT\t_\n");}
{LONG} {printf("LONG\t_\n");}
{RETURN} {printf("RETURN\t_\n");}
{SHORT} {printf("SHORT\t_\n");}
{SIGNED} {printf("SIGNED\t_\n");}
{SWITCH} {printf("SWITCH\t_\n");}
{UNSIGNED} {printf("UNSIGNED\t_\n");}
{VOID} {printf("VOID\t_\n");}
{WHILE} {printf("WHILE\t_\n");}

 /*提前处理浮点数+uU的异常*/
{floatexcption} {printf("Float Execption: %s\n",yytext);} 
 /*数字表示*/
{decimal} {
	if(IsDecimals(yytext))	
		printf("REAL10\t%s\n",yytext);
	else
		printf("INT10\t%s\n",yytext);}
{octal}  {		
	if(IsDecimals(yytext))	
		printf("REAL8\t%lf\n",d_Oct2Dec(yytext));
	else
		printf("INT8\t%d\n",Oct2Dec(yytext));}
{hexadecimal} {
	if(IsDecimals(yytext))	
		printf("REAL16\t%lf\n",d_Hex2Dec(yytext));
	else
		printf("INT16\t%d\n",Hex2Dec(yytext));}
 /*异常数字处理*/
{excption} {printf("Number Execption:  %s\n",yytext);}

 /*跳过空白和注释*/
{whitespace} {}
{comment} {printf("This is a commit.\n");}

 /*运算符*/
 /*算术运算符*/
{ADD} {printf("%s\t_\n",yytext);}
{SUB} {printf("%s\t_\n",yytext);}
{MUL} {printf("%s\t_\n",yytext);}
{QUO} {printf("%s\t_\n",yytext);}
{REM} {printf("%s\t_\n",yytext);}
{INC} {printf("%s\t_\n",yytext);}
{DEC} {printf("%s\t_\n",yytext);}
 /*逻辑运算符*/
{LAND} {printf("%s\t_\n",yytext);}
{LOR} {printf("%s\t_\n",yytext);}
{NOT} {printf("%s\t_\n",yytext);}
 /*赋值运算符*/
{ASSIGN} {printf("%s\t_\n",yytext);}
{ADD_ASSIGN} {printf("%s\t_\n",yytext);}
{SUB_ASSIGN} {printf("%s\t_\n",yytext);}
{MUL_ASSIGN} {printf("%s\t_\n",yytext);}
{QUO_ASSIGN} {printf("%s\t_\n",yytext);}
{REM_ASSIGN} {printf("%s\t_\n",yytext);}
{AND_ASSIGN} {printf("%s\t_\n",yytext);}
{OR_ASSIGN} {printf("%s\t_\n",yytext);}
{XOR_ASSIGN} {printf("%s\t_\n",yytext);}
{SHL_ASSIGN} {printf("%s\t_\n",yytext);}
{SHR_ASSIGN} {printf("%s\t_\n",yytext);}
{AND_NOT_ASSIGN} {printf("%s\t_\n",yytext);}
 /*位运算符*/
{AND} {printf("%s\t_\n",yytext);}
{OR} {printf("%s\t_\n",yytext);}
{XOR} {printf("%s\t_\n",yytext);}
{SHL} {printf("%s\t_\n",yytext);}
{SHR} {printf("%s\t_\n",yytext);}
{AND_NOT} {printf("%s\t_\n",yytext);}
 /*关系运算符*/
{EQL} {printf("%s\t_\n",yytext);}
{LSS} {printf("%s\t_\n",yytext);}
{GTR} {printf("%s\t_\n",yytext);}
{NEQ} {printf("%s\t_\n",yytext);}
{LEQ} {printf("%s\t_\n",yytext);}
{GEQ} {printf("%s\t_\n",yytext);}
 /*标点符号*/
{LPAREN} {printf("%s\t_\n",yytext);}
{LBRACK} {printf("%s\t_\n",yytext);}
{LBRACE} {printf("%s\t_\n",yytext);}
{COMMA} {printf("%s\t_\n",yytext);}
{PERIOD} {printf("%s\t_\n",yytext);}
{RPAREN} {printf("%s\t_\n",yytext);}
{RBRACK} {printf("%s\t_\n",yytext);}
{RBRACE} {printf("%s\t_\n",yytext);}
{SEMICOLON} {printf("%s\t_\n",yytext);}
{COLON} {printf("%s\t_\n",yytext);}
{POT} {printf("%s\t_\n",yytext);}
{DQUA} {printf("%s\t_\n",yytext);}
{SQUA} {printf("%s\t_\n",yytext);}


{identifier} {printf("IDN\t%s\n",yytext);}
{errno} {printf("On line %d,mystery character:  %s\n",yylineno,yytext);}
%%
int IsDecimals(char temp[])						//判断是否是小数
{
	for (int i = 1;i < strlen(temp);i++)
	{
		if(temp[i]=='.')
			return 1;
	}
	return 0;
}
int Oct2Dec(char temp[])						//整数八进制转十进制
{
	int sum = 0;
	for (int i = 1;i < strlen(temp);i++)
	{
		sum = sum * 8 + temp[i] - '0';
	}
	return sum;
}
float d_Oct2Dec(char temp[])						//小数八进制转十进制
{
	float sum1 = 0,sum2=temp[strlen(temp) - 1] - '0';
	int i;
	for (i = 1;i < strlen(temp)&&temp[i]!='.';i++)
	{
		sum1 = sum1 * 8 + temp[i] - '0';
	}
	for (int j = strlen(temp) - 2;j > i;j--)
	{
		sum2=sum2/8+ temp[j] - '0';
	}
	sum2=sum2/8;
	return sum1+sum2;
}
int Hex2Dec(char temp[])                                                //整数>十六进制转十进制
{
        int sum = 0;
        int mid[100];
        for (int ii = 0;ii < strlen(temp);ii++)
        {
                if (temp[ii] == 'a' || temp[ii] == 'A')
                        mid[ii] = 10;
                else if (temp[ii] == 'b' || temp[ii] == 'B')
                        mid[ii] = 11;
                else if (temp[ii] == 'c' || temp[ii] == 'C')
                        mid[ii] = 12;
                else if (temp[ii] == 'd' || temp[ii] == 'D')
                        mid[ii] = 13;
                else if (temp[ii] == 'e' || temp[ii] == 'E')
                        mid[ii] = 14;
                else if (temp[ii] == 'f' || temp[ii] == 'F')
                        mid[ii] = 15;
                else mid[ii] = temp[ii] - '0';
        }
        int i;
        for (i = 2;i < strlen(temp);i++)
        {
                sum = sum * 16 + mid[i];
        }
        return sum;
}

float d_Hex2Dec(char temp[])						//小数十六进制转十进制
{
	int mid[100];
	for (int ii = 0;ii < strlen(temp);ii++)
	{
		if (temp[ii] == 'a' || temp[ii] == 'A')
			mid[ii] = 10;
		else if (temp[ii] == 'b' || temp[ii] == 'B')
			mid[ii] = 11;
		else if (temp[ii] == 'c' || temp[ii] == 'C')
			mid[ii] = 12;
		else if (temp[ii] == 'd' || temp[ii] == 'D')
			mid[ii] = 13;
		else if (temp[ii] == 'e' || temp[ii] == 'E')
			mid[ii] = 14;
		else if (temp[ii] == 'f' || temp[ii] == 'F')
			mid[ii] = 15;
		else mid[ii] = temp[ii] - '0';
	}
	float sum1 = 0, sum2 = mid[strlen(temp)-1];
	int i;
	for (i = 2;i < strlen(temp) && mid[i] != '.'-'0';i++)
	{
		sum1 = sum1 * 16 + mid[i];
	}
	for (int j = strlen(temp) - 2;j > i;j--)
	{
		sum2 = sum2 / 16 + mid[j];
	}
	sum2 = sum2 / 16;
	return sum1 + sum2;
}
int main(int argc,char **argv)
{
        yylineno = 1;
        yylex();
        return 0;
}
int yywarp(){
        return 1;
}
