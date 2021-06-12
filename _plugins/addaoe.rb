require 'nokogiri'

Jekyll::Hooks.register :accueil, :post_render do |post|
    puts (post.image)
    #post.content.gsub("<h1", "<h1 data-aoe=\"popIn\"")
    doc = Nokogiri::HTML(post.content)
    #h1 = doc.css("h1").attr("data-aoe" => "popIn")
    if (post.image == "left") 
        h1 = doc.css("h1").attr("data-aos" => "fade-right")
        p = doc.css("p").attr("data-aos" => "fade-right")
        img = doc.css("img").attr("data-aos" => "fade-left")
    elsif (post.image == "right") 
        h1 = doc.css("h1").attr("data-aos" => "fade-left")
        p = doc.css("p").attr("data-aos" => "fade-left")
        img = doc.css("img").attr("data-aos" => "fade-right")
    end
    post.output = doc.to_html.to_s
    post.content = doc.to_html.to_s
end