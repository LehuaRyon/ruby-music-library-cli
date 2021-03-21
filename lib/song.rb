
class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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
        song = self.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if !(genre.songs.include?(self))
            genre.songs << self
        end
    end

    # def genre=(genre)
    #     if @genre == nil
    #       @genre = genre
    #     else
    #       @genre= @genre
    #     end
    #     if self.genre != nil
    #       @genre.add_song(self)
    #     end
    #     @genre
    # end    

    def self.find_by_name(name)
        all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    # def self.new_from_filename(filename)
    #     info = filename.split(" - ")
    #     artist, name, genre = info[0], info[1], info[2].gsub( ".mp3" , "")
    #     genre = Genre.find_or_create_by_name(genre)
    #     artist = Artist.find_or_create_by_name(artist)
    #     new(name,artist,genre)
    # end
    def self.new_from_filename(name)
        song_name = name.split(" - ")[1]
        artist_name = name.split(" - ")[0]
        genre_name = name.split(" - ")[2].chomp(".mp3")
        song = self.find_or_create_by_name(song_name)
        song.artist = Artist.find_or_create_by_name(artist_name)
        song.genre = Genre.find_or_create_by_name(genre_name)
        song
      end

    def self.create_from_filename(name)
        @@all << self.new_from_filename(name)
    end
end