import csv
import yaml
from pathlib import Path
from typing import List

ICD_FIELDS = ['name','swc','stype']
SCH_FIELDS = ['start','task','duration']

def get_existing_path(path:str) -> Path:
    p = Path(path)
    assert p.exists(), 'Error: %s does not exists!' % path
    return p

class ElopConf():

    '''Class to handle the ELOP environment'''
    def __init__(self,
                 icd_parh: str,
                 sch_path: str,
                 ssm_conf_path: str
                ) -> None:
        self.__icd: List[dict]  = self.__parse_icd(icd_parh)
        self.__sch: List[dict] = self.__parse_sch(sch_path)
        self.__ssm: dict = self.__parse_ssm(ssm_conf_path)

    @property
    def icd(self):
         return self.__icd

    @property
    def sch(self):
         return self.__sch

    @property
    def ssm(self):
         return self.__ssm
    
    def __parse_icd(self,path:str) -> List[dict]:
        with get_existing_path(path).open('r') as f:
            return list(csv.reader(f))
    
    def __parse_sch(self,path:str) -> dict:
        with get_existing_path(path).open('r') as f:
                return [k for k in csv.DictReader(f, fieldnames=SCH_FIELDS)]

    def __parse_ssm(self,path:str) -> dict:
        with get_existing_path(path).open('r') as f:
            return next(yaml.safe_load_all(f), None)
                
    def get_signal(self,sgn: str) -> dict:
        return next(filter(lambda x: x['name'] == sgn, self.__icd), None)
    
    def get_task_scheduling(self, task: str) -> dict:
        return next(filter(lambda x: x['task'] == task, self.__sch), None)

    def get_task(self, ssm_state: str, swc: str) -> str:
        s = self.__ssm[ssm_state]
        return next(filter(lambda x: swc in s[x], s), None)
    
    def get_swc_from_sgn(self,sgn: str) -> str:
        swc_i = ICD_FIELDS.index('swc')
        sgn_i = ICD_FIELDS.index('name')
        for x in self.__icd:
            if x[sgn_i] == sgn:
                 return x[swc_i]
        return None