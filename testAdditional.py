"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

class TestUnit(testLib.RestTestCase):
    """Issue a REST API request to run the unit tests, and analyze the result"""
    def testUnit(self):
        respData = self.makeRequest("/TESTAPI/unitTests", method="POST")
        self.assertTrue('output' in respData)
        print ("Unit tests output:\n"+
               "\n***** ".join(respData['output'].split("\n")))
        self.assertTrue('totalTests' in respData)
        print "***** Reported "+str(respData['totalTests'])+" unit tests. nrFailed="+str(respData['nrFailed'])
        # When we test the actual project, we require at least 10 unit tests
        minimumTests = 10
        if "SAMPLE_APP" in os.environ:
            minimumTests = 4
        self.assertTrue(respData['totalTests'] >= minimumTests,
                        "at least "+str(minimumTests)+" unit tests. Found only "+str(respData['totalTests'])+". use SAMPLE_APP=1 if this is the sample app")
        self.assertEquals(0, respData['nrFailed'])



class TestCommands(testLib.RestTestCase):
    """Test adding users, logins, etc."""

    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)


    def testAddUser1(self):
        respData = self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 1)

    def testAddUser2(self):
        self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_USER_EXISTS)

    def testAddUser3(self):
        respData = self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'a'*129, 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

    def testAddUser4(self):
        respData = self.makeRequest("/user/add", method="POST", data = { 'user_name' : '', 'password' : 'password'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

    def testAddUser5(self):
        respData = self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'user1', 'password' : 'a'*129} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD)

    def testLogin1(self):
        self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/user/login", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'})
        self.assertResponse(respData, count = 2, errCode = testLib.RestTestCase.SUCCESS)

    def testLogin2(self):
        self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'} )
        self.makeRequest("/user/login", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'})
        respData = self.makeRequest("/user/login", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'})
        self.assertResponse(respData, count = 3, errCode = testLib.RestTestCase.SUCCESS)

    def testLogin3(self):
        self.makeRequest("/user/add", method="POST", data = { 'user_name' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/user/login", method="POST", data = { 'user_name' : 'user1', 'password' : 'PASSWORD'})
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)    
















    