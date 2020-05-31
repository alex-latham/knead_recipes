class RecipeInstructions
  attr_reader :list

  def initialize(instructions_json)
    @list = get_instructions(instructions_json[0])
  end

  private

  def get_instructions(instructions_json)
    return if instructions_json.nil?

    instructions_json[:steps].map do |step|
      step[:step]
    end
  end
end
