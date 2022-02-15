//https://www.spoj.com/problems/PRIME1/

//
//	
//Peter wants to generate some prime numbers for his cryptosystem. Help him!
//Your task is to generate all prime numbers between two given numbers!
//
//Input
//
//The input begins with the number t of test cases in a single line (t<10). In each of the next t lines there are two numbers m and n (1 < m < n < 1000000000, n-m<100000) separated by a space.
//
//Output
//For every test case print all prime numbers p such that m < p < n,
//one number per line, test cases separated by an empty line.
//Example
//Input:
//2
//1 10
//3 5
//
//Output:
//2
//3
//5
//7
//
//3
//5
//
//Warning: large Input/Output data, be careful with certain languages (though most should be OK if the algorithm is well designed)
//
//Information
//After cluster change, please consider PRINT as a more challenging problem.
//
import std.stdio;
import std.algorithm;
import std.string;
import std.conv;
import std.random;
import std.range;
import std.math;
import std.file : _write = write, exists, read,mkdir;


int[] primes=[2];
int i=3;
void consider_(int j){
	assert(i==j);
	if( ! primes.any!(a=>(i%a)==0)){
		primes~=i;
	}
	i+=2;
}
void consider(int j){
	if(j>i){
		consider_(i);
		consider(j);
	}
}

void main(string[] input){
	auto range=stdin.byLineCopy;
	int count=range.front.to!int;
	range.popFront;
	foreach(s;range.take(count)){
		int[] n=s.splitter(' ').map!(a=>a.to!int).array;
		if(n.length==2){
			consider(sqrt(n[1].to!float).to!int+100);
			//primes.writeln;
			foreach(p;max(n[0],2)..n[1]+1){
				if( ! primes.any!(a=>(p%a)==0 && p!=a)){
					p.writeln;
				}
			}
			writeln;
		}
	}
}
