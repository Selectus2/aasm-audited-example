class AuditsController < ApplicationController
  def index
    @audits = Audited::Audit.all
    render json: {
      data: @audits.to_a,
      message: "Audits listed successfully"
    }
  end
end
