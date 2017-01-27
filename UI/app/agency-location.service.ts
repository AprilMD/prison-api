import { Injectable } from '@angular/core';
import { Headers, Http } from '@angular/http';

import 'rxjs/add/operator/toPromise';

import { AgencyLocation } from './agency-location';

@Injectable()
export class AgencyLocationService {
  private locationsUrl = 'api/locations';  // URL to web api

  constructor(private http: Http) { }

  getAgencyLocations(): Promise<AgencyLocation[]> {
    return this.http.get(this.locationsUrl)
              .toPromise()
              .then(response => response.json().data as AgencyLocation[])
              .catch(this.handleError);
  }

  getAgencyLocation(id: number): Promise<AgencyLocation> {
    const url = `${this.locationsUrl}/${id}`;
    return this.http.get(url)
      .toPromise()
      .then(response => response.json().data as AgencyLocation)
      .catch(this.handleError);
  }

  private handleError(error: any): Promise<any> {
     console.error('An error occurred', error); // for demo purposes only
     return Promise.reject(error.message || error);
  }
}
