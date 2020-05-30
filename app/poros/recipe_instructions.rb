class RecipeInstructions
  attr_reader :instructions

  def initialize(instructions_json)
    @instructions = get_instructions(instructions_json[0])
  end

  private

  def get_instructions(instructions_json)
    return if instructions_json.nil?

    instructions_json[:steps].reduce([]) do |acc, instructions|
      acc << { instructions[:number] => instructions[:step] }
    end
  end
end
