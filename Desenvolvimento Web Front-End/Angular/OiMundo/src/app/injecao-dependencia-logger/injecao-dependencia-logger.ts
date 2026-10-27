import { Component, Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
class LoggerService {
  log(msg: string) {
    console.log(`[Logger] ${msg}`);
  }
}

@Component({
  imports: [],
  selector: 'app-injecao-dependencia-logger',
  styleUrl: './injecao-dependencia-logger.css',
  templateUrl: './injecao-dependencia-logger.html',
})
export class InjecaoDependenciaLogger {
  constructor(private logger: LoggerService) { }
}
