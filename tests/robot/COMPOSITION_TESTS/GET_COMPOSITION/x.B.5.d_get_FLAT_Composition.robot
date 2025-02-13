# Copyright (c) 2019 Wladislaw Wagner (Vitasystems GmbH), Pablo Pazos (Hannover Medical School).
#
# This file is part of Project EHRbase
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



*** Settings ***
Documentation       Composition Integration Tests
Metadata            TOP_TEST_SUITE    COMPOSITION

Resource        ../../_resources/keywords/composition_keywords.robot

Force Tags

*** Test Cases ***
Main flow has existing COMPOSITION (FLAT)
    [Tags]
    upload OPT    all_types/ehrn_vital_signs.v2.opt
    create EHR
    commit composition   format=FLAT
    ...                  composition=ehrn_vital_signs.v2__.json
    (FLAT) get composition by composition_uid    ${composition_uid}
    check composition exists

    [Teardown]    restart SUT

Data driven tests for Compare content of compositions with the Original (FLAT)
    [Tags]
    [Template]    Create and compare content of flat compositions

    #template_file_name            flat_composition_file_name
    ehrn_vital_signs.v2.opt        ehrn_vital_signs.v2__.json

[Teardown]    restart SUT

*** Keywords ***
Create and compare content of flat compositions
    [Arguments]    ${template_file_name}          ${flat_composition_file_name}
    upload OPT    all_types/${template_file_name}
    create EHR
    commit composition   format=FLAT
    ...                  composition=${flat_composition_file_name}
    (FLAT) get composition by composition_uid    ${composition_uid}
    check composition exists
    Compare content of compositions with the Original (FLAT)  ${COMPO DATA SETS}/FLAT/${flat_composition_file_name}

