# If foucault is installed successfully, running it on its own source code
# should result in the same file
foucault -o test.tmp ../bootstrapping_foucault/debugging.ruby.markdown
if [diff ../bin/foucault test.tmp >/dev/null] ; then
  echo "success"
else
  echo "fail"
fi
rm test.tmp
