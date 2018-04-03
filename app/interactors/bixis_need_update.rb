class BixisNeedUpdate
  include Interactor

  def call
    request = BixisRequestDate.value
    context.fail! if request && request > 2.minutes.ago
  end
end
