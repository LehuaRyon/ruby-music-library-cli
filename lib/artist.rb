
class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs

    @@all = []

    def initialize(name, song=nil)
        @name = name
        @songs = []
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end


    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end

    def songs
        @songs
    end

    # def songs
    #     Song.all.select {|song| song.artist == self}
    # end

    def add_song(song)
        song.artist = self unless song.artist
        @songs << song unless songs.include?(song)
    end

    def genres
        self.songs.collect{|song| song.genre}.uniq
    end

    # def genres
    #     genres = @songs.collect do |song|
    #       song.genre
    #     end
    #     genres.uniq
    # end
    

end