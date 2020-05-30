class RecipeInstructions
  attr_reader :instructions, :number_of_steps

  def initialize(instructions_json)
    @instructions = get_instructions(instructions_json[0])
    @number_of_steps = get_number_of_steps
  end

  private

  def get_number_of_steps
    return if @instructions.nil?
    @instructions.length
  end

  def get_instructions(instructions_json)
    return if instructions_json.nil?
    instructions_json[:steps].reduce([]) do |acc, instructions|
      acc << { instructions[:number] => instructions[:step] }
    end
  end
end
