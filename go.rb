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
  end
end

get '/' do

  terms = ["magic", "moon", "bugs", "flowers", "tornado", "child", "death"]
  term = terms.sample
  past_tense_verb = Faker::Headline.past_tense_verb
  pronoun = Faker::Headline.pronoun
  number = Faker::Headline.number
  noun = Faker::Headline.noun
  verb = Faker::Headline.verb

  sentences = [
    "#{pronoun.capitalize} #{past_tense_verb} WHAT in WHERE?",
    "#{number} #{noun}s that will #{verb.upcase} your mind",
    "#{pronoun.capitalize} can #{verb} with THIS #{noun}?"
  ]
  headline = sentences.sample
  suckr = ImageSuckr::GoogleSuckr.new
  slim :index, locals: {
    suckr: suckr,
    term: term,
    headline: headline
  }
end
