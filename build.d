#!/usr/bin/rdmd

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.process;
import std.stdio;

void main(string[] args)
{
    auto sourceDir = "source";
    auto binaryDir = "binary";
    auto outputFile = buildPath(binaryDir, "firmware");
    
    string cmd = "rm -f " ~ outputFile;
    system(cmd);

    cmd = "arm-none-eabi-gdc -nophoboslib -nostdinc -nodefaultlibs -nostdlib -fno-emit-moduleinfo -ffunction-sections -fdata-sections"
          ~ " "
          ~ " " ~ sourceDir.dirEntries("*.d", SpanMode.depth).map!"a.name".join(" ")
          ~ " -Wl,-Tsource/linker/linker.ld -Wl,--gc-sections -flto"
          ~ " -o " ~ outputFile;                  
            
    writeln(cmd);
    system(cmd);
    
    system("arm-none-eabi-size " ~ outputFile);
}