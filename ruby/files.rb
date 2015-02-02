# with code blocks
File.open("foo.txt","a") { |f| f << "This is sexy" }

# without code blocks
file = File.open("foo.txt","a")
file << "This is tedious"
file.close
