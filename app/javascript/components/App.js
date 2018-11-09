import React, { Component } from 'react'
import { connect, PromiseState } from 'react-refetch'
import styled from 'styled-components'

export const StyledHeader = styled.h1`
  font-size: 32px;
  text-transform: uppercase;
  font-weight: bold;
  text-align: center;
`

class App extends React.Component {

  render() {
    const { creativeQualitiesFetch } = this.props
    return (
        <div>
          <StyledHeader>Creative Qualities</StyledHeader>
          <div className="qualities">
            <div className="col-md-12">
              <div className="row">
                {creativeQualitiesFetch.fulfilled ? Object.keys(creativeQualitiesFetch.value).map((name,score) => <Panel name={name} score={creativeQualitiesFetch.value[name].score} description={creativeQualitiesFetch.value[name].description} />) :"...Loading"}
              </div>
            </div>
          </div>
        </div>
    )
  }
}

export class Panel extends Component {
  render(){
    return(
    <div className="col-md-4">
      <div className={`panel panel-${this.props.name}`}>
        <div className="panel-heading">
          {this.props.name}
        </div>
        <div className="panel-body">
          <div class={`quality quality-${this.props.name}`}></div>
          <div className="score">
            <small>your score:</small>
            {this.props.score ? this.props.score : "-"}
          </div>
          <p>
            {this.props.description}
          </p>
        </div>
      </div>
    </div>
    )
  }
}



export default connect(props => ({
  creativeQualitiesFetch: `/creative_qualities.json`,
}))(App)