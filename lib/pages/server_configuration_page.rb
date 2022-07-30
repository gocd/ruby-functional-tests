##########################################################################
# Copyright 2022 Thoughtworks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

module Pages
  class ServerConfigurationPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/admin/config/server"
    element :server_management_link, "[data-test-id='server-management-link']"
    element :artifact_management_link, "[data-test-id='artifacts-management-link']"
    element :email_server_link, "[data-test-id='email-server-link']"
    element :job_timeout_link, "[data-test-id='job-timeout-link']"

    element :never_job_timeout_checkbox, "[data-test-id='checkbox-for-job-timeout']"
    element :job_timeout_input, "[data-test-id='form-field-input-default-job-timeout']"

    element :smtp_hostname, "[data-test-id='form-field-input-smtp-hostname']"
    element :smtp_port, "[data-test-id='form-field-input-smtp-port']"

    element :use_smtps_checkbox, "[data-test-id='form-field-input-use-smtps']"
    element :smtp_username, "[data-test-id='form-field-input-smtp-username']"
    element :smtp_password, "[data-test-id='form-field-input-smtp-password']"
    element :sender_email_address, "[data-test-id='form-field-input-send-email-using-address']"
    element :admin_email_address, "[data-test-id='form-field-input-administrator-email']"

    element :flash_message, "div[data-test-id='flash-message-success']"

    element :save_button, "[data-test-id='save']"

  end
end
