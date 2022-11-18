# -*- coding: utf-8 -*-
"""
Created on Fri Nov 18 12:00:32 2022

@author: mstri
"""

f = open("output.txt", "w")
for i in range(256):
    i_bin = bin(i)
    
    ones_count = 0
    
    for j in str(i_bin):
        if j == "1":
            ones_count+=1
    
    input_data = str(i_bin)[2:]
    input_data = "0" * (8 - len(input_data)) + input_data
    
    output = str(bin(ones_count)[2:])
    output = "0" * (16 - len(output)) + output
    
    s = "8'b" + input_data + ": z <= 16'b" + output
    f.write(s)
    f.write("\n")
        
f.close()
        