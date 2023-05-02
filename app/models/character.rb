class Character < ApplicationRecord
  require 'openai'
  def gpt_client
    OpenAI::Client.new(access_token: ENV["OPENAI_TOKEN"])
  end

  def gpt_model
    "text-davinci-003"
  end

  def run_prompt(attribute, prompt, max_tokens)
    response = gpt_client.completions(
      parameters: {
        model: gpt_model,
        prompt: prompt,
        max_tokens: max_tokens
      }
    )
    self.update(attribute => response["choices"][0]["text"])
  end

  def generate_all
    self.generate_traits
    self.generate_backstory
  end

  def generate_traits
    run_prompt(:trait_1, trait_1_prompt, 60)
    run_prompt(:trait_2, trait_2_prompt, 60)
  end

  def generate_backstory
    run_prompt(:backstory, backstory_prompt, 500)
  end

  def trait_1_prompt
    "Describe a positive trait about #{self.name}. Only use one word"
  end

  def trait_2_prompt
    "Describe a negative trait about #{self.name}. Only use one word"
  end

  def backstory_prompt
    "You're a legendary storycrafter. Build a backstory about a fantasy character named #{self.name}. They have #{self.trait_1} and #{self.trait_2} traits."
  end
end
