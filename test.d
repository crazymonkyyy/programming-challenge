import std.stdio;
void main(){
	foreach(s;stdin.byLineCopy){
		if(s=="42"){return;}
		s.writeln;
}}