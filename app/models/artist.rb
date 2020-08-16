class Artist < ActiveRecord::Base

    has_many :songs
    has_many :genres, through: :songs

    def slug
        self.name.downcase.strip.gsub(' ', '-')
    end

    def self.find_by_slug(slug_name)
        self.all.detect {|song| song.slug == slug_name}
    end 

end