class UserObserver < ActiveRecord::Observer
  observe UTeacher, UStudent, UChief
  def after_create(model)
    email = model.email
    params = Hash.new
    params[:type] = model.type
    params[:password] = model.password
    person = Person.find(model.person_id)

    params[:last_name] = person.last_name if person.last_name
    params[:first_name] = person.first_name if person.first_name
    params[:middle_name] = person.middle_name if person.middle_name
    params[:type] = person.type if person.type
    params[:sex] = person.sex.name if person.sex
    params[:military_rank] = person.military_rank if person.military_rank
    params[:scientific_rank] = person.scientific_rank if person.scientific_rank
    params[:scientific_degree] = person.scientific_degree if person.scientific_degree
    params[:post] = person.post if person.post
    params[:chair] = person.chair if person.chair
    params[:group] = person.group if person.group
    params[:course] = person.last_name if person.last_name
    params[:telephone] = person.telephone if person.telephone
    params[:room] = person.room if person.room

    params[:time] = model.created_at
    log email, params, "register_teacher.yml"
  end

  def log(name_record, params, file_name)
    logger = Logger.new(file_name)
    logger.info "#{name_record}:"
    params.each do |key, value|
      logger.info "   #{key}: #{value}"
    end
    logger.close
  end
end