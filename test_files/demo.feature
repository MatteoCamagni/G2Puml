Feature: Temperature impact on software

    Scenario: Temeperature error evaluation
    '''In this scenario is described how the temperature error is generated 
    by the value measured from the MCU'''
        Given the Scheduler Task Queue during the SSM.OPERATION_MODE state
        When the Temperature Measurement reads the RAW_ECU_TEMPERATURE signal
        Then it shall evaluate the ECU_TEMPERATURE signal
        When the Temeprature Monitoring reads the ECU_TEMPERATURE signal
        Then it shall evaluate the ERROR_TEMPERATURE signal
        When the Temeprature Monitoring reads the RAW_ECU_TEMPERATURE signal
        Then it shall evaluate the ERROR_TEMPERATURE signal
        When the SSM Core reads the ERROR_TEMPERATURE signal
        Then it shall evaluate the ACS signal