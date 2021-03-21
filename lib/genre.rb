
class Genre
    extend Concerns::Findable
    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
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
        genre = self.new(name)
        genre.save
        genre
    end

    def songs
        @songs
    end
    
    # def songs
    #     Song.all.select {|song| song.genre == self}
    # end

    def add_song(song)
        song.genre = self unless song.genre
        @songs << song unless songs.include?(song)
    end

    def artists
        self.songs.collect{|song| song.artist}.uniq
    end

    # def artists
    #     artists = @songs.collect do |song|
    #       song.artist
    #     end
    #     artists.uniq
    # end
end