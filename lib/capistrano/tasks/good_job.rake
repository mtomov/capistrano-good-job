# frozen_string_literal: true

plugin = self

namespace :good_job do
  desc "Install good_job systemd service"
  task :install do
    on roles(fetch(:good_job_role)) do |role|
      execute :mkdir, "-p", fetch(:good_job_systemd_conf_dir)

      service_file = File.expand_path("../../templates/good_job.service.erb", __FILE__)
      erb = File.read(service_file)
      file = StringIO.new(ERB.new(erb, trim_mode: "-").result(binding))

      systemd_path = fetch(:good_job_systemd_conf_dir)
      path = "#{systemd_path}/#{fetch(:good_job_service_unit_name)}.service"

      execute :mkdir, "-p", systemd_path
      upload! file, path

      # Reload systemd
      plugin.execute_systemd("daemon-reload")
      invoke "good_job:enable"
    end
  end

  desc "Uninstall good_job systemd service"
  task :uninstall do
    invoke "good_job:disable"
    on roles(fetch(:good_job_role)) do |role|
      systemd_path = fetch(:good_job_systemd_conf_dir)
      execute :rm, "-f", "#{systemd_path}/#{fetch(:good_job_service_unit_name)}*"

      plugin.execute_systemd("daemon-reload")
    end
  end

  desc "Enable good_job systemd service"
  task :enable do
    on roles(fetch(:good_job_role)) do
      plugin.execute_systemd("enable", fetch(:good_job_service_unit_name))
    end
  end

  desc "Disable good_job systemd service"
  task :disable do
    on roles(fetch(:good_job_role)) do
      plugin.execute_systemd("disable", fetch(:good_job_service_unit_name))
    end
  end

  desc "Start good_job service via systemd"
  task :start do
    on roles(fetch(:good_job_role)) do
      plugin.execute_systemd("start", fetch(:good_job_service_unit_name))
    end
  end

  desc "Stop good_job service via systemd"
  task :stop do
    on roles(fetch(:good_job_role)) do
      plugin.execute_systemd("stop", fetch(:good_job_service_unit_name))
    end
  end

  desc "Restart good_job service via systemd"
  task :restart do
    on roles(fetch(:good_job_role)) do
      plugin.execute_systemd("restart", fetch(:good_job_service_unit_name))
    end
  end

  desc "Reload good_job service via systemd"
  task :reload do
    on roles(fetch(:good_job_role)) do
      plugin.execute_systemd("reload", fetch(:good_job_service_unit_name))
    end
  end

  desc "Get good_job service status via systemd"
  task :status do
    on roles(fetch(:good_job_role)) do
      plugin.execute_systemd("status", fetch(:good_job_service_unit_name))
    end
  end
end
