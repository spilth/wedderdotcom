require 'sinatra'
require 'slim'
require 'image_suckr'
require 'ffaker'

module Faker
  BASE_LIB_PATH = "."

  module Headline
    extend ModuleUtils
    extend self

    def past_tense_verb
      PAST_TENSE_VERB.rand
    end

    def pronoun
      PRONOUN.rand
    end

    def noun
      NOUN.rand
    end

    def verb
      VERB.rand
    end

    def number
      NUMBER.rand
    end

    def headline
      HEADLINE.rand
    end
  end
end

suckr = ImageSuckr::GoogleSuckr.new

get '/' do
  past_tense_verb = Faker::Headline.past_tense_verb
  pronoun = Faker::Headline.pronoun
  number = Faker::Headline.number
  noun = Faker::Headline.noun
  noun2 = Faker::Headline.noun
  verb = Faker::Headline.verb

  headline = eval %Q["#{Faker::Headline.headline}"]

  image_url = suckr.get_image_url({"q" => "#{noun} #{noun2}", "imgtype" => "photo", "imgsz" => "medium"})

  slim :index, locals: {
    suckr: suckr,
    image_url: image_url,
    headline: headline
  }
end
