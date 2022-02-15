//https://www.spoj.com/problems/PALIN/

//
//	A positive integer is called a palindrome if its representation in the decimal system is the same when read from left to right and from right to left. For a given positive integer K of not more than 1000000 digits, write the value of the smallest palindrome larger than K to output. Numbers are always displayed without leading zeros.
//
//Input
//The first line contains integer t, the number of test cases. Integers K are given in the next t lines.
//
//Output
//For each K, output the smallest palindrome larger than K.
//
//Example
//Input:
//2
//808
//2133
//
//Output:
//818
//2222
//
//Warning: large Input/Output data, be careful with certain languages
//
import std.stdio;
import std.algorithm;
import std.string;
import std.conv;
import std.random;
import std.range;
import std.math;
import std.file : _write = write, exists, read,mkdir;

int[2] cleanupchunk(T)(T a){
	if(a.length==1){
		return [100,a[0]];
	}
	return a[0..2];
}
char[2] restringify(int[2] a){
	if(a[0]>99){
		return [' ',a[1].to!string[0]];
	}
	return [a[0].to!string[0],a[1].to!string[0]];
}
int[2] fromtuple(T)(T a){
	return [a[0],a[1]];
}
auto reindex(string indexstring,string lengthstring="l",R)(R range){
	static struct reindex_{
		R range;
		int j=0;
		auto opIndex(int i){
			i+=j;
			mixin("return range["~indexstring~"];");
		}
		auto length(){
			auto l=range.length;
			return mixin(lengthstring)-j;
		}
		auto front(){
			return this[0];
		}
		void popFront(){
			j++;
		}
		bool empty(){
			return length==0;
		}
	}
	return reindex_(range);
}
void main(string[] input){
	auto range=stdin.byLineCopy;
	int count=range.front.to!int;
	range.popFront;
	foreach(s;stdin.byLineCopy.take(count)){
		int[2][] a=
			zip(
				s.map!(a=>a.to!int-'0'.to!int).array.reindex!("i","l/2"),
				s.map!(a=>a.to!int-'0'.to!int).array.reindex!("$-i-1","l/2"))
			.map!fromtuple.array;
		if(s.length%2==1){
			a~=[100,s[$/2].to!int-'0'.to!int];
		}
		a[0][1]++;
		foreach(ref e;a.slide(2)){
			if(e[0][0]!=e[0][1]){
				if(e[0][0] < e[0][1]){
					e[0][1]=e[0][0];
					e[1][1]++;
				} else {
					e[0][1]=e[0][0];
				}
			}
		}
		if(a[$-1][1]>9){
			a[$-1][0]++;
			a[$-1][1]=0;
		}
		if(s.length%2==0){
			if(a[$-1][0]>a[$-1][1]){
				a[$-1][1]=a[$-1][0];
			}
			if(a[$-1][0]<a[$-1][1]){
				a[$-1][0]++;
				if(a[$-1][0]>9){
					a[$-2][0]++;
					a[$-2][1]++;
					a[$-1][0]=0;
				}
				a[$-1][1]=a[$-1][0];
			}
		}
		a.map!restringify
			.reindex!("i<$?i:$-(i-$)-1][i<$","l*2")
			.filter!(a=>a!=' ')
			.write;
	}
}
