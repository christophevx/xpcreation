require 'facebookbusiness'
require 'fileutils'
require 'open-uri'

id = "#{ARGV[0]}"
pageid = "#{ARGV[1]}"

FacebookAds.configure do |config|
    config.access_token = '#{ARGV[2]}'
    config.app_secret = '#{ARGV[3]}'
end

user = FacebookAds::User.get(id ,'')

print user.id + "\n"
print user.name + "\n"

page = FacebookAds::Page.get(pageid)
feeds = page.feed({
    fields: {  },
})

feeds.each do |feed|
    print "---------------------------------------------"
    puts feed.message

    feedid = feed.id
    timeOfTruc = feed.created_time.strftime("%F")
    
    filename = timeOfTruc + "-" + feedid + ".md"
    puts "filename : " + filename

    File.open("_facebook/" + filename, "w") { |f| 
        f.puts("---")
        f.puts("title: " + feed.message)
        f.puts("name: " + feedid)
        f.puts("---")
    }

    folderimg = 'assets/images/' + feedid
    FileUtils.mkdir_p folderimg

    puts feed.as_json

    x=1
    feed.attachments.each do |attachment|
        puts attachment.attributes
        filentodl = attachment["media"]["image"]["src"]
        File.open(folderimg + "/" + 'image' + x.to_s + '.png', 'wb') { |file|
            file << open(filentodl).read
        }
        x=x+1

        attachment["subattachments"]["data"].each do |subattachment|
            subfilentodl = subattachment["media"]["image"]["src"]
            puts subfilentodl
            File.open(folderimg + "/" + 'image' + x.to_s + '.png', 'wb') { |file|
                file << open(subfilentodl).read
            }
            x=x+1
        end

        #filename = 
        #puts attachment.methods
        #puts attachment.to_json
    end
end
