
class PeopleService
  def process_people
    People.connection.execute(
      "UPDATE people SET name = CONCAT(name, ' ', surname), enabled = TRUE WHERE created_at <= '#{2.years.ago}'"
    )
  end 
end
