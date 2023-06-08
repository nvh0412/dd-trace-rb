require "#{Rails.root}/app/jobs/test_job"

class JobsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Queue job
    job_id = SecureRandom.uuid
    Resque.enqueue(TestJob, job_id: job_id)

    # Return response
    render json: { job_id: job_id }
  end
end
