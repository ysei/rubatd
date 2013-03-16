class Rubatd::DataStore
  attr_reader :db, :type

  def initialize(type, db_adapter_class, config)
    @type = type
    @db = db_adapter_class.new(config)
    @accessors = {}
  end

  def save(model)
    accessor(model.type_name).save(model)
  end

  def get(model_type, id)
    accessor(model_type).get(id)
  end

  def fetch_referrers(referee, model_type)
    accessor(referee.type_name).referrers(model_type, referee.id)
  end

  private

  def accessor(model_type)
    @accessors[model_type] ||= begin
      container = Rubatd.const_get(:"#{type.to_s.camelize}Accessors")
      container.for(db, model_type)
    end
  end
end
