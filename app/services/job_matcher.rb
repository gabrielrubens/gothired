class JobMatcher
  def initialize(gemini = nil)
    @gemini = gemini || GeminiService.new
  end

  def match_percentage(cv_path, job_description)
    cv_text = get_cv_text(cv_path)
    job_description = get_job_description(job_description)
    response = @gemini.generate_content(get_prompt(cv_text, job_description))

    p "RESPONDE IS: #{response}"
    response.to_f
  end

  private

  def get_cv_text(cv_path)
    Pdf::Extractor.call(Rails.root.join(cv_path))
  end

  def get_job_description(job_description)
    File.read(Rails.root.join(job_description))
  end

  def get_prompt(cv_text, job_description)
    prompt = <<~PROMPT
      Task: Compare the provided CV with the job description and calculate a match percentage.

      CV TEXT:
      #{cv_text}

      JOB DESCRIPTION:
      #{job_description}

      Instructions:
      1. Identify matching keywords, phrases, and concepts between the CV and job description.
      2. Calculate a match percentage score from 0.0 to 100.0 based on the similarity of skills, experience, and qualifications.
      3. Provide your match score as a single number between 0.0 and 100.00.
      4. Output format: Just the numerical score (e.g., "85.09").
    PROMPT

    prompt
  end
end
