make
echo "finish" | vvp cpu.out 
diff ../testdata/output.txt ../testdata/output_ref.txt
