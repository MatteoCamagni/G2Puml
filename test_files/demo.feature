Feature: Temperature impact on software (OPERATION_MODE)

    Scenario: Temperature error evaluation from ECU temperature signal
        '''In this scenario is described how the temperature error is generated from the value measured from the MCU and when it is evaluated by the SSM Core'''

        Given the Scheduler Task Configuration during the SSM.OPM.DEFAULT state
        When the Temperature Measurement reads the RAW_MICRO_TEMPERATURE signal
        Then it shall evaluate the MICRO_TEMPERATURE signal
        When the Temperature Monitoring reads the MICRO_TEMPERATURE signal
        Then it shall evaluate the ERROR_OVERTEMPERATURE signal
        When the Temperature Monitoring reads the RAW_MICRO_TEMPERATURE signal
        Then it shall evaluate the ERROR_OVERTEMPERATURE signal
        When the SSM Core reads the ERROR_OVERTEMPERATURE signal
        Then it shall evaluate the ACS signal