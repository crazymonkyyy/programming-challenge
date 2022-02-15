import std.stdio;
import std.algorithm;
import std.string;
import std.conv;
import std.random;
import std.range;
import std.math;
import std.file : _write = write, exists, read,mkdir;

import std.process;
import arsd.dom;
import arsd.http2;
string exe(string input){//"make the annoying gtk warnings in zenity go away, mmmk?" the function
	import std.process;
	auto config=Config.stderrPassThrough;
	return input.executeShell(null,config).output[0..$-1];
}

enum broswer="vivaldi-stable ";
enum file="nemo ";
enum path="src/d/spoj/";
enum texteditor="textadept -f ";
enum z="zenity ";
enum term="lxterminal --working-directory=";

string addcomment(string s){
	return "//"~s;
}

void main(string[] s){
	(broswer~"https://www.spoj.com/problems/classical/unsolved/").spawnShell;
	auto web=(z~"--entry").exe;
	string describ=Document.fromUrl(web).querySelector("#problem-body").innerText;
	describ.writeln;
	int a;
	if(exists(path~"store")){
		a=(cast(int[])read(path~"store"))[0];
	} else {
		_write(path~"store",[0]);
	}
	a.writeln;
	a++;
	_write(path~"store",[a]);
	if(a%10==0){
		mkdir(path~a.to!string);
	}
	int b=(a/10)*10;
	b.writeln;
	("touch "~path~b.to!string~"/"~a.to!string~".d").executeShell;
	File o=File(path~b.to!string~"/"~a.to!string~".d","w");
	o.writeln(web.addcomment);
	o.writeln;
	foreach(s_;describ.splitter('\n')){
		o.writeln(s_.addcomment);
	}
	o.writeln("import std.stdio;");
	o.writeln("import std.algorithm;");
	o.writeln("import std.string;");
	o.writeln("import std.conv;");
	o.writeln("import std.random;");
	o.writeln("import std.range;");
	o.writeln("import std.math;");
	o.writeln("import std.file : _write = write, exists, read,mkdir;");
	o.writeln;
	o.writeln;
	o.writeln("void main(string[] input){");
	o.writeln("	foreach(s;stdin.byLineCopy){");
	o.writeln("		");
	o.writeln("	}");
	o.writeln("}");
	o.close;
	
	(texteditor~path~b.to!string~"/"~a.to!string~".d &").spawnShell;
	(file~path~b.to!string~"/").spawnShell;
	(term~path~b.to!string~" &").spawnShell;
}