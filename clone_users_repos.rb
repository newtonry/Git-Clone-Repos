require 'open-uri'

system("rm clone_script.sh")

puts "Please enter your github username:"
username = gets.chomp

File.open("clone_script.sh", 'a') do |f|
  addLine = false

  open("https://github.com/" + username + "?tab=repositories") do |url|
    url.each_line do |line|
      if addLine
        link = (line[line.index('"')+1..-1])
        link = (link[0..link.index('"')-1])
        f.puts("git clone https://github.com" + link + ".git")
        addLine = false
      end
    
      addLine = true if line.include?('<h3 class="repolist-name">')
    end
  end
end

system("bash clone_script.sh")