//https://www.spoj.com/problems/ONP/

//
//	
//Transform the algebraic expression with brackets into RPN form (Reverse Polish Notation). Two-argument operators: +, -, *, /, ^ (priority from the lowest to the highest), brackets ( ). Operands: only letters: a,b,...,z. Assume that there is only one RPN form (no expressions like a*b*c).
//
//Input
//
//t [the number of expressions < 100]
//expression [length < 400]
//[other expressions]
//
//
//Text grouped in [ ] does not appear in the input file.
//
//Output
//
//The expressions in RPN form, one per line.
//
//Example
//
//Input:
//3
//(a+(b*c))
//((a+b)*(z+x))
//((a+t)*((b+(a+c))^(c+d)))
//
//Output:
//abc*+
//ab+zx+*
//at+bac++cd+^*
//
//
import std.stdio;
import std.algorithm;
import std.string;
import std.conv;
import std.random;
import std.range;
import std.math;
import std.file : _write = write, exists, read,mkdir;

import std.ascii;


void main(string[] input){
	auto range=stdin.byLineCopy;
	int count=range.front.to!int;
	range.popFront;
	foreach(s;range.take(count)){
		char[] sym;
		char[] op;
		foreach(c;s){
			if(c.isAlpha){
				//sym~=c;
				c.write;
			} else {
				if(c!=')'){
					op~=c;
				} else {
					while(op[$-1]!='('){
						op[$-1].write;
						op=op[0..$-1];
					}
					op=op[0..$-1];
				}
			}
		}
		op.reverse.filter!(a=>a!='(').writeln;
	}
}
