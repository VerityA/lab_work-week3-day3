require('pry-byebug')
require_relative('models/artist.rb')
require_relative('models/album.rb')



artist1 = Artist.new({'name' => 'Franz Ferdinand'})

artist1.save()

album1 = Album.new(
  {'name' => 'Greatest Hits',
    'genre' => 'Indie',
    'artist_id' => artist1.id()
    })

album1.save()










binding.pry

nil
