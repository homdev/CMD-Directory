module ProjectsHelper
  def evaluation_color_class(score)
    case score
    when 0..1
      "bg-red-500"   # Rouge
    when 1..3
      "bg-yellow-500" # Orange
    when 3..5
      "bg-green-500" # Vert
    else
      "bg-gray-300"  # Gris pour les valeurs non définies
    end
  end
end
