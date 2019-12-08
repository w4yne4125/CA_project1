make
echo "finish" | vvp cpu.out 
diff output.txt reff.txt
