Feature: Doing http requests

  Scenario: Send text body and headers
    Given I set "X-My-Header" header with value "Something"
    And I send a POST request to "/requests/echo" with body:
    """
    Something
    """
    Then the response code should be 200
    Then the response should contain json:
    """
        {
            "method": "POST",
            "headers": {
                "X-My-Header": "Something"
            },
            "body": "Something"
        }
    """

  Scenario: Send form data
    Given I set "X-My-Header" header with value "Something"
    And I send a POST request to "/requests/echo" with values:
    """
    name=Wilson
    age=42
    """
    Then the response should contain json:
    """
        {
            "method": "POST",
            "body": "age=42&name=Wilson"
        }
    """

  Scenario: Send file
    Given I set "X-My-Header" header with value "Something"
    And I attach the file "$PWD/features/data/favicon.ico" as "upload"
    And I send a POST request to "/requests/echo"
    Then the response should contain json:
    """
        {
            "method": "POST",
            "files": [
                {
                    "key": "upload",
                    "name": "favicon.ico"
                }
            ]
        }
    """

  Scenario: Set variable
    Given I set "username" variable with value "Bob"
    And I send a POST request to "/requests/echo" with body:
    """
    Hello $username
    """
    Then the response should contain json:
    """
        {
            "body": "Hello Bob"
        }
    """