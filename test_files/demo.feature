Feature: Temperature impact on software

    Scenario Outline: Temperature error evaluation from MICRO temperature signal
        """In this scenario is described how the temperature error is generated from the value measured from the MCU and when it is evaluated by the SSM Core"""

        Given the Scheduler Task Configuration during the <State> state
        When the Temperature Measurement reads the RAW_MICRO_TEMPERATURE signal
        Then it shall evaluate the MICRO_TEMPERATURE signal
        When the Temperature Monitoring reads the MICRO_TEMPERATURE signal
        Then it shall evaluate the ERROR_OVERTEMPERATURE signal
        When the SSM Core reads the ERROR_OVERTEMPERATURE signal
        Then it shall evaluate the ACS.STATE signal

        Scenarios:
            |   State                   |
            |   SSM.OPM.CONTROL		    |
            |   SSM.OPM_RCV.MCU		    |
            |   SSM.OPM_RCV.COMM		|
            |   SSM.OPM_RCV.ROTOR_BLOCK	|
            |   SSM.OPM_RCV.ROTOR_POS	|
            |   SSM.OPM_RCV.TEMP		|
            |   SSM.OPM_RCV.DERATING	|
            |   SSM.OPM_RCV.SPEED		|

    Scenario Outline: Overtemperature scenario
        """
        In this scenario is described the reaction of the SSM to an overtemperature situation
        """

        Given the Scheduler Task Configuration during the <State> state
        And the MICRO_TEMPERATURE signal equal to ECU_OVERTEMP_UP_TRESHOLD from the last ECU_OVERTEMP_ERROR_TRIGGER_TIME seconds
        When the Temperature Monitoring reads the MICRO_TEMPERATURE signal
        Then it shall set the ERROR_OVERTEMPERATURE signal equal to TRUE
        When the SSM Core reads the ERROR_OVERTEMPERATURE signal
        Then it shall set the ACS.STATE signal equal to SSM.OPM_REC.TEMP
        """
        The SSM is now in the Operation Mode Recovery state for the overtemperature
        """
        Scenarios:
            |   State                   |
            |   SSM.OPM.CONTROL		    |
            |   SSM.OPM_RCV.MCU		    |
            |   SSM.OPM_RCV.COMM		|
            |   SSM.OPM_RCV.ROTOR_BLOCK	|
            |   SSM.OPM_RCV.ROTOR_POS	|
            |   SSM.OPM_RCV.TEMP		|
            |   SSM.OPM_RCV.DERATING	|
            |   SSM.OPM_RCV.SPEED		|

