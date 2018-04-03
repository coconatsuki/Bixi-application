class StationsNeedCreateOrUpdate
  include Interactor

  def call
    request = StationsRequestDate.value
    context.fail! if request && request > 1.day.ago
  end
end
