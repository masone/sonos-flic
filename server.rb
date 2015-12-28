require 'sinatra'
require 'sonos'

set :bind, '0.0.0.0'

before do
  @player = Player.new
end

get '/radio24' do
  playing = @player.radio24_bathroom
  "Radio24 #{playing ? 'on' : 'off'}"
end

get '/discover' do
  playing = @player.discover_weekly_party
  "Discover #{playing ? 'on' : 'off'}"
end

get '/party' do
  party = @player.toggle_party
  "Party #{party ? 'on' : 'off'}"
end

class Player

  def radio24_bathroom
    system.party_over
    b = select_speaker('Bathroom')
    return b.stop && false if b.is_playing?

    b.clear_queue
    b.volume = 10
    b.add_to_queue('x-rincon-mp3radio://icecast.radio24.ch/radio24')
    b.play
  end

  def discover_weekly_party
    m = party_master
    return m.stop && false if m.is_playing?

    m.clear_queue
    m.volume = 30
    m.add_spotify_to_queue(id: '4cBfjj6H32iO1VekiDGPYB', type: 'playlist', user: 'spotifydiscover')
    m.play
  end

  def toggle_party
    if partying?
      party_master.stop
      system.party_over
      false
    else
      system.party_mode
      party_master.play
      true
    end
  end

  private

  def select_speaker(speaker_name)
    system.speakers.find { |speaker| speaker.name == speaker_name }
  end

  def party_master
    system.party_mode unless partying?
    system.rescan
    group = system.groups.select { |g| g.speakers.count > 1 }.first
    group.master_speaker
  end

  def partying?
    system.groups.count <= 2
  end

  def system
    @system ||= Sonos::System.new
  end
end
